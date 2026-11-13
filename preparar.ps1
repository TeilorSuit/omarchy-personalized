param(
    [Parameter(Mandatory=$true)][string]$Destino,
    [Parameter(Mandatory=$true)][string]$Gif,
    [Parameter(Mandatory=$true)][string]$Fondos,
    [Parameter(Mandatory=$true)][string]$Video
)
$ErrorActionPreference = 'Stop'
if (Test-Path -LiteralPath $Destino) { throw 'El destino ya existe; elige una carpeta nueva.' }
foreach ($path in @($Gif, $Video, (Join-Path $Fondos '01-rei.jpg'), (Join-Path $Fondos '02-roxy.jpg'), (Join-Path $Fondos '03-zerotwo.jpg'))) {
    if (!(Test-Path -LiteralPath $path -PathType Leaf)) { throw "Falta el archivo: $path" }
}
git clone https://github.com/piermark/omarchytv.git $Destino
if ($LASTEXITCODE -ne 0) { throw 'No se pudo clonar OmarchyTV.' }
git -C $Destino checkout --detach 0365e6b704ebb0f99c03b5c460fd36d5e84fdb9f
if ($LASTEXITCODE -ne 0) { throw 'No se pudo seleccionar la versión base.' }
git -C $Destino apply --check (Join-Path $PSScriptRoot 'personalizacion.patch')
if ($LASTEXITCODE -ne 0) { throw 'El parche no coincide con la versión base.' }
git -C $Destino apply (Join-Path $PSScriptRoot 'personalizacion.patch')
if ($LASTEXITCODE -ne 0) { throw 'No se pudo aplicar el parche.' }
$main = Join-Path $Destino 'launcher/app/src/main'
$wall = Join-Path $main 'assets/wallpapers/marlo-anime'
New-Item -ItemType Directory -Force -Path $wall, (Join-Path $main 'res/raw') | Out-Null
Copy-Item -LiteralPath $Gif -Destination (Join-Path $main 'assets/eris-panel.gif')
Copy-Item -LiteralPath $Video -Destination (Join-Path $main 'res/raw/teilor_saver.mp4')
foreach ($name in @('01-rei.jpg', '02-roxy.jpg', '03-zerotwo.jpg')) { Copy-Item -LiteralPath (Join-Path $Fondos $name) -Destination (Join-Path $wall $name) }
Write-Host 'Preparado. Revisa README.md antes de compilar e instalar.'
