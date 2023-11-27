## How to deploy a new version

You have to be logged in to Google Cloud and have access to the project. Then you can run the following commands (build
and push docker image):

```bash
export GOOGLE_PROJECT_ID=project_id
docker login -u oauth2accesstoken -p "$(gcloud auth print-access-token)" https://eu.gcr.io
docker build -t eu.gcr.io/${GOOGLE_PROJECT_ID}/kotrzina/court-reservations:latest .
docker push eu.gcr.io/${GOOGLE_PROJECT_ID}/kotrzina/court-reservations:latest
docker inspect eu.gcr.io/${GOOGLE_PROJECT_ID}/kotrzina/court-reservations:latest | jq '.[0].RepoDigests[0]'

# Update image in Cloud Run - terraform file
```
