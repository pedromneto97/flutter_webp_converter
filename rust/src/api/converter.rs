use std::{
    path::{Path, PathBuf},
    thread,
};
use webp::{Encoder, WebPConfig};

pub struct ConvertParameters {
    pub quality: f32,
    pub output_directory: String,
    pub lossless: bool,
    pub method: i8,
}
#[derive(Debug)]
pub enum ConvertError {
    IoError,
    ImageError,
    EncoderError,
    WebPConfigError,
    WebPEncodingError,
}

fn get_image_name_from_path(image_path: &str) -> String {
    let image_path = Path::new(image_path);
    image_path
        .file_stem()
        .unwrap()
        .to_str()
        .unwrap()
        .to_string()
}

fn generate_webp_config_from_convert_parameters(
    convert_parameters: ConvertParameters,
) -> Result<WebPConfig, ConvertError> {
    let mut webp_config = WebPConfig::new().map_err(|_| ConvertError::WebPConfigError)?;
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

    Ok(webp_config)
}

fn generate_output_path(image_path: &String, output_directory: &String) -> PathBuf {
    let image_name = get_image_name_from_path(image_path);
    let output_path = Path::new(&output_directory)
        .join(image_name)
        .with_extension("webp");

    output_path
}

pub fn convert_image(
    image_path: String,
    convert_parameters: ConvertParameters,
) -> Result<String, ConvertError> {
    let thread = thread::spawn(move || {
        let output_path = generate_output_path(&image_path, &convert_parameters.output_directory);
        let webp_config = generate_webp_config_from_convert_parameters(convert_parameters)?;

        let img = image::open(image_path).map_err(|_| ConvertError::ImageError)?;
        let encoder = Encoder::from_image(&img).map_err(|_| ConvertError::EncoderError)?;
        let webp = encoder
            .encode_advanced(&webp_config)
            .map_err(|_| ConvertError::WebPEncodingError)?;

        std::fs::write(&output_path, &*webp).map_err(|_| ConvertError::IoError)?;

        Ok(output_path.into_os_string().into_string().unwrap())
    });

    thread.join().unwrap()
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
