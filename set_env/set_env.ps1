$env:YC_CLOUD_ID=$(yc config get cloud-id)
$env:YC_FOLDER_ID=$(yc config get folder-id)
$env:YC_TOKEN=$(yc iam create-token)

Write-Host "Environment variables set."