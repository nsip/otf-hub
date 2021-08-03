#!/bin/bash

set -e

echo "OTF PDM"

###export
NATS_HOST=127.0.0.1  # benthos refer

N3_HOST=127.0.0.1
N3_PORT=1323

CLASSIFIER_HOST=127.0.0.1
CLASSIFIER_PORT=1576

ALIGNER_HOST=127.0.0.1
ALIGNER_PORT=1324

LEVELLER_HOST=127.0.0.1
LEVELLER_PORT=1327

WEIGHTING_HOST=127.0.0.1
WEIGHTING_PORT=1329

OTF_ROOT=~/Desktop/OTF
PDM_ROOT=$OTF_ROOT/otf-hub
OTF_TESTDATA=$OTF_ROOT/otf-testdata
###

# create demo input/audit/nats folder structure
mkdir -p ${PDM_ROOT}/{in/{brightpath,lpofa,maps/{align,level},maths-pathway,spa},audit/{align,level},result}

# remove existing contexts
rm -rf /home/qmiao/Desktop/OTF/n3/n3-web/server/n3w/contexts

# create new contexts
sleep 4
curl -s -X POST http://${N3_HOST}:${N3_PORT}/admin/newdemocontext -d userName=nsipOtf -d contextName=alignmentMaps
curl -s -X POST http://${N3_HOST}:${N3_PORT}/admin/newdemocontext -d userName=nsipOtfLevel -d contextName=levellingMaps

# maps
sleep 4
cp ${OTF_TESTDATA}/pdm_testdata/maps/alignmentMaps/nlpLinks.csv  ${PDM_ROOT}/in/maps/align
sleep 4
cp ${OTF_TESTDATA}/pdm_testdata/maps/alignmentMaps/providerItems.csv  ${PDM_ROOT}/in/maps/align
sleep 4
cp ${OTF_TESTDATA}/pdm_testdata/maps/levelMaps/scaleMap.csv  ${PDM_ROOT}/in/maps/level
sleep 4
cp ${OTF_TESTDATA}/pdm_testdata/maps/levelMaps/scoresMap.csv  ${PDM_ROOT}/in/maps/level

# data
sleep 4
cp ${OTF_TESTDATA}/pdm_testdata/BrightPath.json.brightpath ${PDM_ROOT}/in/brightpath
sleep 4
cp ${OTF_TESTDATA}/pdm_testdata/MathsPathway.csv ${PDM_ROOT}/in/maths-pathway

sleep 20m