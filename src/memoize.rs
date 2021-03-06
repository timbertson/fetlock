use log::*;
use std::pin::Pin;
use futures::future::*;
use either::Either;
use futures::task::{Context,Poll};

// TODO feels like there should be something in futures already...
pub struct Memoize<T> {
	value: Either<T, Pin<Box<dyn Future<Output=T>>>>,
}

impl<T> Memoize<T> {
	pub fn new(f: Pin<Box<dyn Future<Output=T>>>) -> Memoize<T> {
		Memoize { value: Either::Right(f) }
	}
}

impl<T:Clone+Unpin> Future for Memoize<T> {
	type Output=T;
	fn poll(self: Pin<&mut Self>, cx: &mut Context<'_>) -> Poll<Self::Output> {
		let mut ptr = Pin::into_inner(self);
		match &mut ptr.value {
			Either::Left(v) => {
				debug!("future already resolved...");
				Poll::Ready(v.clone())
			},
			Either::Right(fut) => {
				debug!("polling future...");
				match fut.as_mut().poll(cx) {
					Poll::Pending => Poll::Pending,
					Poll::Ready(v) => {
						ptr.value = Either::Left(v.clone());
						Poll::Ready(v)
					},
				}
			}
		}
	}
}