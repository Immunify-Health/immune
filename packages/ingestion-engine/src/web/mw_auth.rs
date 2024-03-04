use crate::web::AUTH_TOKEN;
use crate::{Error, Result};
use tower_cookies::Cookies;
use axum::response::Response;
use axum::extract::Request;
use axum::middleware::Next;

pub async fn mw_require_auth(
    cookies: Cookies,
    req: Request,
    next: Next,
) -> Result<Response> {
    Ok(next.run(req).await)
}