# Commit agent – stages all changes and commits with a message
param(
    [string]$Message = "커밋 메시지 필요합니다"
)

if (-not $Message) {
    Write-Host "Usage: .\agent\commit_agent.ps1 '메시지'"
    exit 1
}

git add -A
git commit -m $Message
