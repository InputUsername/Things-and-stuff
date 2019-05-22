use std::env;
use std::fs;
use std::io;

const SEP: &str = "::=";
const IN: &str = ":::";
const OUT: &str = "~";

#[derive(Debug)]
struct Rule<'a> {
    lhs: &'a str,
    rhs: &'a str,
}

fn parse(program: &str) -> (Vec<Rule>, &str) {
    let input = program.lines()
        .skip_while(|&line| line != SEP)
        .skip(1)
        .next()
        .expect("Program has no input");

    let rules = program.lines()
        .take_while(|&line| line != SEP)
        .filter_map(|line| {
            if line.trim().is_empty() {
                return None;
            }
            let mut i = line.split(SEP);
            Some(Rule {
                lhs: i.next().expect("Rule has no LHS"),
                rhs: i.next().expect("Rule has no RHS"),
            })
        })
        .collect();
    
    (rules, input)
}

fn run(rules: &[Rule], input: &str) -> String {
    let mut output = input.to_string();
    let mut user_input = String::new();

    loop {
        let mut stop = true;

        for rule in rules {
            if output.contains(rule.lhs) {
                if rule.rhs == IN {
                    io::stdin().read_line(&mut user_input).expect("Could not read user input");
                    user_input.pop();
                    output = output.replacen(rule.lhs, &user_input, 1);
                } else if rule.rhs.starts_with(OUT) {
                    output = output.replacen(rule.lhs, "", 1);
                    print!("{}", &rule.rhs[1..]);
                } else {
                    output = output.replacen(rule.lhs, rule.rhs, 1);
                }

                stop = false;
            }
        }

        if stop {
            break;
        }
    }

    output
}

fn main() {
    let file = env::args().nth(1).expect("Expected a file");
    let program = fs::read_to_string(file).expect("Could not read file");

    let (rules, input) = parse(&program);
    println!("{}", run(&rules, input));
}
