mod this {
	pub mod is {
		pub mod a {
			pub mod very {
				pub mod deeply {
					pub mod nested {
						pub fn function() {
							println!("You have wasted time by typing out the full path to this function.")
						}
					}
				}
			}
		}
	}
}

fn main() {
	println!("Hello world!");

	this::is::a::very::deeply::nested::function();
}
