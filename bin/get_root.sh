#!/bin/bash
cd ..
ROOT=$(basename `pwd`)
cd -
ROOT2=$(basename `pwd`)

echo export CS_NUM=${ROOT}/${ROOT2}
export CS_NUM=${ROOT}/${ROOT2}
