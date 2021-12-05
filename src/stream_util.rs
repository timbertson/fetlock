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

pub async fn map_parallel<
	T,
	R,
	S: Stream<Item = T>,
	Fut: Future<Output = Result<R>>,
	Func: FnMut(T) -> Fut,
>(
	concurrency: usize,
	items: S,
	f: Func,
) -> Result<Vec<R>> {
	let results = items
		.map(f)
		.buffered(concurrency)
		// TODO there should be some way to not have to to two collects...
		.collect::<Vec<Result<R>>>().await;
	results.into_iter().collect::<Result<Vec<R>>>()
}
