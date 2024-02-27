use crate::model::{ModelController, Ehr, EhrForCreate};
use crate::Result;
use axum::{ Router, Json };
use axum::extract::{ Path, State, FromRef };
use axum::routing::{ post, delete };

#[derive(Clone, FromRef)]
struct AppState {
    mc: ModelController   // Sub-state management
}

pub fn routes(mc: ModelController) -> Router {
    let app_state = AppState { mc };

    Router::new()
        .route("/ehr", post(create_ehr).get(list_ehr))
        .route("/ehr/:id", delete(delete_ehr))
        .with_state(app_state)
}

async fn create_ehr(
    State(mc): State<ModelController>,
    Json(ehr_fc): Json<EhrForCreate>,
) -> Result<Json<Ehr>> {
    println!("->> {:<12} - create_ehr", "HANDLER");

    let ehr = mc.create_ehr(ehr_fc).await?;

    Ok(Json(ehr))
}

async fn list_ehr(
    State(mc): State<ModelController>,
) -> Result<Json<Vec<Ehr>>> {
    println!("->> {:<12} - list_ehr", "HANDLER");

    let ehr = mc.list_ehr().await?;

    Ok(Json(ehr))
}

async fn delete_ehr(
    State(mc): State<ModelController>,
    Path(id): Path<u64>,
) -> Result<Json<Ehr>> {
    println!("->> {:<12} - delete_ehr", "HANDLER");

    let ehr = mc.delete_ehr(id).await?;
    
    Ok(Json(ehr))
}