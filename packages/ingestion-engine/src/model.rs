use crate::{ Error, Result };
use serde::{ Serialize, Deserialize };
use std::sync::{ Mutex, Arc };


#[derive(Clone, Debug, Serialize)]
pub struct Ehr {
    pub id: u64,
    pub title: String,
}

#[derive(Deserialize)]
pub struct EhrForCreate {
    pub title: String,
}



#[derive(Clone)]
pub struct ModelController {
    ehr_store: Arc<Mutex<Vec<Option<Ehr>>>>,
}

// Constructor
impl ModelController {
    pub async fn new() -> Result<Self> {
        Ok(Self {
            ehr_store: Arc::default(),
        })
    }
}

impl ModelController {
    pub async fn create_ehr(&self, ehr_fc: EhrForCreate) -> Result<Ehr> {
        let mut store = self.ehr_store.lock().unwrap();

        let id = store.len() as u64;
        let ehr = Ehr {
            id,
            title: ehr_fc.title,
        };
        store.push(Some(ehr.clone()));

        Ok(ehr)
    }

    pub async fn list_ehr(&self) -> Result<Vec<Ehr>> {
        let store = self.ehr_store.lock().unwrap();

        let ehr = store.iter().filter_map(|t| t.clone()).collect();

        Ok(ehr)
    }

    pub async fn delete_ehr(&self, id: u64) -> Result<Ehr> {
        let mut store = self.ehr_store.lock().unwrap();

        let ehr = store.get_mut(id as usize).and_then(|t| t.take());

        ehr.ok_or(Error::EhrDeleteFailIdNotFound { id })

    }
}