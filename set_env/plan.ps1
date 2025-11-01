if (terraform validate) {
    terraform plan 
    Write-Host ""
    Write-Host "Terraform Plan Complete"
} else {
    Write-Host ""
    Write-Host "Terraform Not Validate"
}