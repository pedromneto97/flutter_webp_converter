use std::path::Path;
use std::thread;
use uuid::Uuid;
use webp::{Encoder, WebPConfig};

pub struct ConvertParameters {
    pub quality: f32,
    pub output_directory: String,
    pub lossless: bool,
    pub method: i8,
}

pub fn convert_image(image_path: String, convert_parameters: ConvertParameters) -> String {
    let thread = thread::spawn(move || {
        let img = image::open(image_path).unwrap();

        let encoder: Encoder = Encoder::from_image(&img).unwrap();

        let mut webp_config = WebPConfig::new().unwrap();
        webp_config.quality = convert_parameters.quality;
        webp_config.lossless = if convert_parameters.lossless { 1 } else { 0 };
        webp_config.alpha_compression = if convert_parameters.lossless { 0 } else { 1 };
        webp_config.method = match convert_parameters.method {
            0 => 0,
            1 => 1,
            2 => 2,
            3 => 3,
            4 => 4,
            5 => 5,
            _ => 6,
        };

        let webp = encoder.encode_advanced(&webp_config).unwrap();

        let uuid = Uuid::new_v4();
        let output_path = Path::new(&convert_parameters.output_directory)
            .join(uuid.to_string())
            .with_extension("webp");

        std::fs::write(&output_path, &*webp).unwrap();

        output_path.into_os_string().into_string().unwrap()
    });

    thread.join().unwrap()
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
