#![allow(unused)]

use axum::response::IntoResponse;
use axum::{
    routing::get,
    Router,
};
use axum::routing::get_service;
use axum::extract::{
    Query,
    Path
};
use serde::Deserialize;
use tower_http::services::ServeDir;

pub use self::error::{ Error, Result };

mod error;
mod web;

#[tokio::main]
async fn main() {

    let routes_all = Router::new()
        .merge(routes_hello())
        .merge(web::routes_login::routes())
        .fallback_service(routes_static());



    // let addr = SocketAddr::from(([127, 0, 0, 1], 8080));
    let addr = tokio::net::TcpListener::bind("127.0.0.1:3000").await.unwrap();
    // println!("->> Listening on {addr}\n");
    axum::serve(addr, routes_all)
        .await
        .unwrap();
}

fn routes_static() -> Router {
    Router::new().nest_service("/", get_service(ServeDir::new("./")))
}

fn routes_hello() -> Router {
    Router::new()
        .route("/hello", get(handler_hello))
        .route("/hello2/:name", get(handler_hello2))
}

#[derive(Debug, Deserialize)]
struct HelloParams {
    name: Option<String>,
}

async fn handler_hello(Query(params): Query<HelloParams>) -> impl IntoResponse {
    println!("->> {:<12} - handler_hello - {params:?}", "HANDLER");

    let name = params.name.as_deref().unwrap_or("World!");

    format!("Hello {name}")
}

async fn handler_hello2(Path(name): Path<String>) -> impl IntoResponse {
    println!("->> {:<12} - handler_hello - {name:?}", "HANDLER");

    format!("Hello {name}")
}