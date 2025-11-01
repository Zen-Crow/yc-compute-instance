if (terraform destroy -auto-approve) {
    Write-Host ""
    Write-Host "Terraform Destroy Complete"
} else {
    Write-Host ""
    Write-Host "Terraform Destroy With Errors"
}