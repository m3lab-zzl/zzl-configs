# -*- coding: utf-8 -*-
"""
Convert mat file to json and yaml file
    support both old version (<7.3)
    and new version (>=7.3) of matlab file
"""

# try import pymatreader and numpy, if not exist, install them
import os
import json
import sys
from pymatreader import read_mat
import numpy as np
from scipy.sparse import csc_matrix


def clean_value(value):
    if isinstance(value, np.ndarray):
        return value.tolist()
    elif isinstance(value, csc_matrix):
        if verbose:
            return value.toarray().tolist()
        else:
            return np.shape(value.toarray())
    elif isinstance(value, list):
        return [clean_value(v) for v in value]
    else:
        return value


def clean_dict(mat: dict):
    """
    - mat may contain nested dict
    - keys startswith "__" are not needed
    - np.ndarray and scipy.sparse.csc_matrix should be converted to list so that it can be saved as json/yaml
    """
    new_dict = {}
    for key, value in mat.items():
        if key.startswith("__"):
            continue
        if isinstance(value, dict):
            value = clean_dict(value)
        else:
            value = clean_value(value)
        new_dict[key] = value

    return new_dict


def mat2json(matfile: str, jsonfile: str):
    mat = read_mat(matfile)
    clean_mat = clean_dict(mat)

    json.dump(clean_mat, open(jsonfile, "w"))
    print(f"--> {os.path.abspath(jsonfile)} Saved!")


if __name__ == "__main__":
    if len(sys.argv) == 2:
        matfile = sys.argv[1]
        verbose = False
    elif len(sys.argv) == 3:
        matfile = sys.argv[1]
        verbose = True
    else:
        raise SyntaxError(
            "usage: python mat2json_yaml.py /path/to/your/matfile.mat [verbose]"
        )

    jsonfile = matfile.strip(".mat") + ".json"
    mat2json(matfile, jsonfile)
