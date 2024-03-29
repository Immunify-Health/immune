#![allow(unused)]
use serde_json::json;

use anyhow::Result;
#[tokio::test]
async fn quick_dev() -> Result<()> {
    let hc = httpc_test::new_client("http://localhost:3000")?;

    // hc.do_get("/hello?name=Akan").await?.print().await?;
    hc.do_get("/hello2/Akan").await?.print().await?;

    // hc.do_get("/src/main.rs").await?.print().await?;



    
    let req_login = hc.do_post(
        "/api/login",
        json!({
            "username": "demo1",
            "pwd": "welcome"
        })
    );

    req_login.await?.print().await?;


    // let req_create_ticket = hc.do_post(
    //     "/api/ehr",
    //     json!({
    //         "title": "akanimoh osutuk 1",
    //     })
    // );

    // req_create_ticket.await?.print().await?;

    hc.do_get("/api/ehr").await?.print().await?;


    Ok(())
}




