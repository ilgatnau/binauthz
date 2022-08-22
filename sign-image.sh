#!/bin/bash

ATTESTOR_PROJECT_ID=binauthz-attestor-test-project
ATTESTATION_PROJECT_ID=binauthz-attestions-tst-prj

ATTESTOR_NAME=demo-attestor
IMAGE_PATH=gcr.io/google-containers/redis
IMAGE_DIGEST=sha256:cb111d1bd870a6a471385a4a69ad17469d326e9dd91e0e455350cacf36e1b3ee
IMAGE_TO_ATTEST="${IMAGE_PATH}@${IMAGE_DIGEST}"

KMS_KEY_PROJECT_ID=vm-import-346415
KMS_KEY_LOCATION=global
KMS_KEYRING_NAME=keyring-example
KMS_KEY_NAME=asymmetric-key-example
KMS_KEY_VERSION=1

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

gcloud container binauthz attestations list\
    --project="${ATTESTATION_PROJECT_ID}"\
    --attestor="projects/${ATTESTOR_PROJECT_ID}/attestors/${ATTESTOR_NAME}"\
    --artifact-url="${IMAGE_TO_ATTEST}"