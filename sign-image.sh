#!/bin/bash

ATTESTOR_PROJECT_ID=binauthz-attestor-test-project
ATTESTATION_PROJECT_ID=binauthz-attestions-tst-prj

ATTESTOR_NAME=demo-attestor
IMAGE_PATH=gcr.io/google-containers/addon-resizer-arm64
IMAGE_DIGEST=sha256:ee76fa03fd8bf2105813681b8a50c90581777dcd2aa3676c69c74892727ebd51
IMAGE_TO_ATTEST="${IMAGE_PATH}@${IMAGE_DIGEST}"

KMS_KEY_PROJECT_ID=vm-import-346415
KMS_KEY_LOCATION=global
KMS_KEYRING_NAME=keyring-example
KMS_KEY_NAME=asymmetric-key-example
KMS_KEY_VERSION=1

gcloud auth activate-service-account --key-file=./sa-key.json

# Creates attestation
gcloud beta container binauthz attestations sign-and-create \
    --project="${ATTESTATION_PROJECT_ID}" \
    --artifact-url="${IMAGE_TO_ATTEST}" \
    --attestor="${ATTESTOR_NAME}" \
    --attestor-project="${ATTESTOR_PROJECT_ID}" \
    --keyversion-project="${KMS_KEY_PROJECT_ID}" \
    --keyversion-location="${KMS_KEY_LOCATION}" \
    --keyversion-keyring="${KMS_KEYRING_NAME}" \
    --keyversion-key="${KMS_KEY_NAME}" \
    --keyversion="${KMS_KEY_VERSION}"

# Validates attestation
gcloud container binauthz attestations list\
    --project="${ATTESTATION_PROJECT_ID}"\
    --attestor="projects/${ATTESTOR_PROJECT_ID}/attestors/${ATTESTOR_NAME}"\
    --artifact-url="${IMAGE_TO_ATTEST}" \
    --format=json

# deletes attestation
OCCURRENCE_ID=$(gcloud container binauthz attestations list\
    --project="${ATTESTATION_PROJECT_ID}"\
    --attestor="projects/${ATTESTOR_PROJECT_ID}/attestors/${ATTESTOR_NAME}"\
    --artifact-url="${IMAGE_TO_ATTEST}" \
    --format=json | jq .[].name -r)

OCCURRENCE_ID=$(cut -d'/' -f4 <<< $OCCURRENCE_ID)

curl -H "Authorization: Bearer $(gcloud auth print-access-token)" -X DELETE \
  https://containeranalysis.googleapis.com/v1beta1/projects/${ATTESTATION_PROJECT_ID}/occurrences/${OCCURRENCE_ID}