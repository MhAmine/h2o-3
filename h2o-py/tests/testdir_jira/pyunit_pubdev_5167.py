import h2o
import pandas as pd
import os

from datetime import datetime
from fastparquet import write
from tests import pyunit_utils


def pubdev_5167():
    timestamp = datetime(2018, 1, 16, 22, 29, 27)

    d = {
        'time_col': [timestamp]
    }
    df = pd.DataFrame(data=d)
    write('outfile.parq', df, times='int96')

    parquet = h2o.import_file(path=pyunit_utils.locate("outfile.parq"))
    frame = parquet.as_data_frame()
    os.remove('outfile.parq')

    assert frame.shape == (1, 1)
    assert frame.loc[0][0] == 1516141767000


if __name__ == "__main__":
    pyunit_utils.standalone_test(pubdev_5167)
else:
    pubdev_5167()
