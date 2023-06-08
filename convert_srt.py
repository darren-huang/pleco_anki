import argparse
from opencc import OpenCC

FORMATTER = {
    "trad": OpenCC("s2tw"),
    "simp": OpenCC("t2s"),
}


def convert_file(input_file, output_file, output_format="trad"):
    print(f"converting '{input_file}' to {output_format} chinese")
    if not output_file:
        split_in = input_file.split(".")
        name, ext = split_in[:-1], split_in[-1]
        output_file = f"{'.'.join(name)}.{output_format}.{ext}"
    print(f"saving to '{output_file}'")
    with open(input_file, "r") as input_f, open(output_file, "w") as output_f:
        output_f.write(FORMATTER[output_format].convert(input_f.read()))
    print("done")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("input_file")
    parser.add_argument("-o", "--output_file", default=None)
    parser.add_argument(
        "-f",
        "--format",
        choices=["trad", "simp"],
        default="trad",
    )
    args = parser.parse_args()
    convert_file(args.input_file, args.output_file, args.format)
