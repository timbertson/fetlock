use anyhow::*;
use futures::{future, Future, Stream, StreamExt, TryFutureExt};

pub async fn foreach_unordered<
	T,
	S: Stream<Item = T>,
	Fut: Future<Output = Result<()>>,
	Func: FnMut(T) -> Fut,
>(
	concurrency: usize,
	items: S,
	f: Func,
) -> Result<()> {
	let stream = items
		.map(f)
		.buffer_unordered(concurrency)
		.fold(Ok(()), |acc, item| future::ready(acc.and(item)));
	TryFutureExt::into_future(stream).await
}
