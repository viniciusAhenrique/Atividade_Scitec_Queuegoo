$failed = $false
Write-Output 'QueueGOO — Verificação de ambiente'
$pythonFound = $false
foreach ($candidate in @('python', 'python3', 'py')) {
    if (Get-Command $candidate -ErrorAction SilentlyContinue) {
        try {
            $version = & $candidate --version 2>&1
            if ($LASTEXITCODE -eq 0 -and "$version" -match '^Python 3\.') {
                Write-Output "[OK] Python encontrado: $version"
                $pythonFound = $true
                break
            }
        } catch { }
    }
}
if (-not $pythonFound) {
    Write-Output '[ERRO] Python 3 não encontrado ou não executa.'
    $failed = $true
}
foreach ($tool in @('node', 'npm')) {
    try {
        $command = if ($tool -eq 'npm') { 'npm.cmd' } else { $tool }
        if (-not (Get-Command $command -ErrorAction SilentlyContinue)) { throw 'Ausente' }
        $version = & $command --version 2>&1
        if ($LASTEXITCODE -ne 0) { throw 'Falha ao executar' }
        Write-Output "[OK] $tool encontrado: $version"
    } catch {
        Write-Output "[ERRO] $tool não encontrado ou não executa."
        $failed = $true
    }
}
if ($failed) {
    Write-Output 'O ambiente local não está pronto. Utilize outro computador preparado ou consulte CODESPACES.md.'
    exit 1
}
Write-Output 'Ferramentas disponíveis. Siga o README da atividade para instalar as dependências e executar.'
exit 0
