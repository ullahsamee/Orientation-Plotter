#! /usr/bin/env python3

import sys
import pystar
import csv
import subprocess


def main():
    print(f'Reading {sys.argv[1]}')
    document = pystar.load(sys.argv[1])

    inner_dict = list(document['images'].items())[0]
    headers = inner_dict[0]
    particles = inner_dict[1]

    index_angle_tilt = headers.index('rlnAngleTilt')
    index_angle_psi = headers.index('rlnAnglePsi')

    angles = [(x[index_angle_tilt], x[index_angle_psi]) for x in particles]

    print('Writing angles')
    with open('out.csv', 'w', newline = '') as out:
        csv_out = csv.writer(out)
        csv_out.writerow(('Tilt', 'Psi'))
        for row in angles:
            csv_out.writerow(row)

    print('Making plots')
    subprocess.run(['Rscript', 'orientation-plotter.R'])


if __name__ == '__main__':
    main()
