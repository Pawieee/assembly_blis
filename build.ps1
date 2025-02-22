param (
    [string]$filename
)

# Assemble the .asm file
ml /c /coff "$filename.asm"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!"
    exit
}

# Link the .obj file
link /subsystem:console "$filename.obj"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!"
    exit
}

Write-Host "Build successful!"