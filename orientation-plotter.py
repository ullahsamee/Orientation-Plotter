#!/usr/bin/env python3

import pystar
import csv
import subprocess
import argparse
import os


def main():
    args = parser.parse_args()
    script_location = os.path.dirname(os.path.realpath(__file__))
    if args.psi:
        psi_rot = True
    else:
        psi_rot = False

    document = pystar.load(args.star_file)

    inner_dict = list(document['images'].items())[0]
    headers = inner_dict[0]
    particles = inner_dict[1]

    index_angle_tilt = headers.index('rlnAngleTilt')
    index_angle_psi = headers.index('rlnAnglePsi')
    index_angle_rot = headers.index('rlnAngleRot')

    angles = [(x[index_angle_tilt], x[index_angle_psi], x[index_angle_rot]) for x in particles]

    with open(args.csv_out, 'w', newline = '') as out:
        outfile = csv.writer(out)
        outfile.writerow(('Tilt', 'Psi', 'Rot'))
        for row in angles:
            outfile.writerow(row)

    if not args.no_plots:
        split_path = os.path.split(args.csv_out)
        subprocess.run(['Rscript', os.path.join(script_location, 'orientation-plotter.R'),
                        split_path[0], split_path[1], str(psi_rot)])


parser = argparse.ArgumentParser(description = 'Re-plot particle orientations using viridis color scheme. Death to Jet!')
parser.add_argument('star_file', help = '.star file with particle orientations')
parser.add_argument('-o', '--csv-out', help = 'Name of output csv. Default out.csv',
                    default = os.path.join('.', 'out.csv'), type = str)
parser.add_argument('--no-plots', help = 'Do not plot orientations. CSV only.',
                    action = 'store_true', default = False)
parser.add_argument('--psi', help = 'Plot tilt and psi instead of tilt and rot',
                    action = 'store_true')


if __name__ == '__main__':
    main()
