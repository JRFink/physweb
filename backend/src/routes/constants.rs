use axum::{extract::Path, Json, http::StatusCode};
use serde::Serialize;
 
#[derive(Serialize, Clone)]
pub struct PhysicsConstant {
    pub symbol: String,
    pub name: String,
    pub value: f64,
    pub unit: String,
    pub category: String,
    pub description: String,
}
 
fn all_constants() -> Vec<PhysicsConstant> {
    vec![
        PhysicsConstant {
            symbol: "c".into(),
            name: "Speed of light".into(),
            value: 299_792_458.0,
            unit: "m/s".into(),
            category: "electromagnetic".into(),
            description: "Speed of light in a vacuum".into(),
        },
        PhysicsConstant {
            symbol: "h".into(),
            name: "Planck constant".into(),
            value: 6.626_070_15e-34,
            unit: "J·s".into(),
            category: "quantum".into(),
            description: "Relates photon energy to its frequency".into(),
        },
        PhysicsConstant {
            symbol: "G".into(),
            name: "Gravitational constant".into(),
            value: 6.674_30e-11,
            unit: "m³/(kg·s²)".into(),
            category: "gravitational".into(),
            description: "Proportionality constant in Newton's law of gravitation".into(),
        },
        PhysicsConstant {
            symbol: "e".into(),
            name: "Elementary charge".into(),
            value: 1.602_176_634e-19,
            unit: "C".into(),
            category: "electromagnetic".into(),
            description: "Electric charge carried by a single proton".into(),
        },
        PhysicsConstant {
            symbol: "k_B".into(),
            name: "Boltzmann constant".into(),
            value: 1.380_649e-23,
            unit: "J/K".into(),
            category: "thermodynamic".into(),
            description: "Relates particle kinetic energy to temperature".into(),
        },
        PhysicsConstant {
            symbol: "N_A".into(),
            name: "Avogadro constant".into(),
            value: 6.022_140_76e23,
            unit: "mol⁻¹".into(),
            category: "thermodynamic".into(),
            description: "Number of constituent particles per mole".into(),
        },
        PhysicsConstant {
            symbol: "epsilon_0".into(),
            name: "Vacuum permittivity".into(),
            value: 8.854_187_812_8e-12,
            unit: "F/m".into(),
            category: "electromagnetic".into(),
            description: "Permittivity of free space".into(),
        },
        PhysicsConstant {
            symbol: "mu_0".into(),
            name: "Vacuum permeability".into(),
            value: 1.256_637_062_12e-6,
            unit: "H/m".into(),
            category: "electromagnetic".into(),
            description: "Permeability of free space".into(),
        },
    ]
}
 
pub async fn list_constants() -> Json<Vec<PhysicsConstant>> {
    Json(all_constants())
}
 
pub async fn get_constant(
    Path(symbol): Path<String>,
) -> Result<Json<PhysicsConstant>, StatusCode> {
    all_constants()
        .into_iter()
        .find(|c| c.symbol == symbol)
        .map(Json)
        .ok_or(StatusCode::NOT_FOUND)
}
