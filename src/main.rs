use clap::{Parser, Subcommand};
use paste::{Paste, PasteCommands};

use colored::*;

mod paste;

#[derive(Debug, Parser)]
#[clap(name = "katbin")]
#[clap(about = "a command line interface for katb.in", long_about = None)]
struct Cli {
    #[clap(subcommand)]
    command: Commands,
}

#[derive(Debug, Subcommand)]
enum Commands {
    #[clap(arg_required_else_help = true)]
    Paste(Paste),
}

fn main() {
    // parse CLI arguments
    let args = Cli::parse();

    // match commands
    match args.command {
        Commands::Paste(paste) => match paste.command.unwrap() {
            PasteCommands::Create(create) => match paste::create_paste(create.body) {
                Ok(paste) => {
                    let url = format!("https://katb.in/{}", paste.id.blue());
                    if paste.is_url {
                        let view_url = format!("https://katb.in/v/{}", paste.id);
                        println!(
                            "Short URL created successfully. Access it at {}, and view it at {}.",
                            url.bright_blue(),
                            view_url.bright_blue()
                        );
                    } else {
                        println!(
                            "Paste created successfully. Access it at {}.",
                            url.bright_blue()
                        );
                    }
                }
                Err(err) => {
                    println!("error: {}", err)
                }
            },
        },
    }
}
