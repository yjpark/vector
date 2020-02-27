use tracing::{span::Span, subscriber::set_global_default};
use tracing_limit::Limit;
use tracing_log::LogTracer;
use tracing_subscriber::{layer::SubscriberExt, FmtSubscriber};

pub use tracing_futures::Instrument;
pub use tracing_tower::{InstrumentableService, InstrumentedService};

pub fn init(color: bool, levels: &str) {
    let subscriber = FmtSubscriber::builder()
        .with_ansi(color)
        .with_env_filter(levels)
        .finish()
        .with(Limit::default());

    let _ = LogTracer::init();
    let _ = set_global_default(subscriber);
}

pub fn current_span() -> Span {
    Span::current()
}
