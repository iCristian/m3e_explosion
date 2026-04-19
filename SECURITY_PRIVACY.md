# 🔐 Security & Privacy Guidelines

This document outlines security practices for **Material 3 Expressive Explosion** to protect developer information and ensure safe public distribution.

---

## ⚠️ What Should NOT Be Committed

The following types of data MUST NEVER be committed to this public repository:

### 1. **Developer Credentials**
- ❌ Personal names or email addresses
- ❌ Phone numbers or contact info
- ❌ Social media handles
- ❌ Developer account usernames

### 2. **Signing Certificates & Keys**
- ❌ Keystore files (`.jks`, `.keystore`)
- ❌ Private keys (`.p8`, `.pem`)
- ❌ Apple provisioning profiles (`.mobileprovision`)
- ❌ Apple development certificates
- ❌ Google Play signing keys

### 3. **Bundle IDs & Identifiers**
- ❌ Personal/company bundle IDs (e.g., `com.cristiancarreno.m3eexplosion`)
- ❌ Reversed domain names
- ❌ App identifiers with personal data

### 4. **API Keys & Secrets**
- ❌ YouTube API keys
- ❌ Backend service credentials
- ❌ OAuth tokens
- ❌ Database credentials
- ❌ Cloud service keys

### 5. **Build Configurations**
- ❌ Signing configurations
- ❌ Production certificates
- ❌ Local development settings with personal data

### 6. **IDE & Environment Files**
- ❌ `.vscode/settings.json` with personal paths
- ❌ `local.properties` with SDK paths
- ❌ `.env` files with private data
- ❌ IDE run configurations with credentials

---

## ✅ What IS Safe to Commit

The following are safe for public repositories:

- ✅ Generic bundle IDs (e.g., `com.example.m3e_demo`)
- ✅ Public documentation & guides
- ✅ Code examples & architecture patterns
- ✅ Configuration examples (`.example` files)
- ✅ Setup instructions & scripts
- ✅ Open-source dependencies & licenses
- ✅ Public configuration constants
- ✅ General development guidelines

---

## 🔒 Protection Mechanisms

### 1. `.gitignore` - File Exclusion

The following patterns are excluded from Git:

```
.env.local              # Local environment variables
.env                    # Environment file
*.jks                   # Android keystores
*.keystore              # Keystore files
*.p8                    # iOS private keys
*.mobileprovision       # iOS provisioning profiles
local.properties        # Local Android config
.vscode/settings.json   # IDE settings
credentials.json        # API credentials
service-account-key.json # Service accounts
```

**Why:** These files contain sensitive data that should not be shared.

### 2. `.env.example` - Configuration Template

Provides a template for required configuration without sensitive values:

```bash
# Public: .env.example
BUNDLE_ID=com.example.m3e_demo
DEVELOPER_NAME=Your Name
DEVELOPER_EMAIL=your.email@example.com
```

**How to use:**
```bash
cp .env.example .env.local
nano .env.local  # Edit with YOUR values
```

**Why:** Developers know what configuration is needed without exposing actual values.

### 3. `setup_local.sh` - Automated Setup

Script to help developers configure local environment safely:

```bash
./setup_local.sh
```

**What it does:**
- Creates `.env.local` (not versioned)
- Prompts for bundle IDs
- Updates local Android/iOS configurations
- Keeps sensitive data on developer's machine only

### 4. Generic Values in Repository

The public repository uses generic values:

```gradle
// ✅ Public repository
applicationId = "com.example.m3e_demo"  // Generic

// ❌ Private (your local machine)
applicationId = "com.cristiancarreno.m3eexplosion"  // Your personal bundle ID
```

---

## 📋 Pre-Commit Checklist

Before pushing to GitHub, verify:

- [ ] No personal bundle IDs in Android files
- [ ] No personal bundle IDs in iOS files
- [ ] No `.env.local` file in staged changes
- [ ] No keystore files (`.jks`) staged
- [ ] No provisioning profiles staged
- [ ] No credentials files staged
- [ ] No IDE personal settings staged
- [ ] No local development paths exposed

**Verify with:**
```bash
# See what will be committed
git status

# Check for sensitive files
git diff --cached

# Verify .gitignore is working
git check-ignore -v .env.local
```

---

## 🚀 Publishing to GitHub

### Safe Publishing Steps

1. **Clean Sensitive Data**
   ```bash
   # Remove any sensitive files
   rm -f .env.local
   rm -f android/app/*.jks
   rm -f ios/*.mobileprovision
   ```

2. **Verify .gitignore**
   ```bash
   # Ensure .gitignore includes all sensitive patterns
   cat .gitignore | grep -E ".env|*.jks|*.keystore"
   ```

3. **Check Git History**
   ```bash
   # Ensure no sensitive data in previous commits
   git log --all -- .env.local
   git log --all -- "*.jks"
   ```

4. **Configure Git Hooks (Optional)**
   ```bash
   # Create a pre-commit hook to prevent accidents
   cat > .git/hooks/pre-commit << 'EOF'
   #!/bin/bash
   
   # Prevent committing sensitive files
   PATTERNS=(
       ".env.local"
       ".env"
       "*.jks"
       "*.keystore"
       "*.p8"
       "local.properties"
   )
   
   for pattern in "${PATTERNS[@]}"; do
       if git diff --cached --name-only | grep -q "$pattern"; then
           echo "❌ ERROR: Attempting to commit sensitive file: $pattern"
           exit 1
       fi
   done
   EOF
   chmod +x .git/hooks/pre-commit
   ```

5. **Create Repository**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Material 3 Expressive Explosion"
   git branch -M main
   git remote add origin https://github.com/yourusername/m3e_explosion.git
   git push -u origin main
   ```

---

## 👥 For Other Developers

When cloning this repository:

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/m3e_explosion.git
   cd m3e_explosion
   ```

2. **Set up local environment**
   ```bash
   cp .env.example .env.local
   nano .env.local  # Add YOUR configuration
   ```

3. **Configure bundle IDs for your development**
   ```bash
   # Android
   nano android/app/build.gradle.kts
   # Update: applicationId = "com.yourcompany.m3eexplosion"
   
   # iOS
   # Open ios/Runner.xcworkspace
   # Update Bundle Identifier in Build Settings
   ```

4. **Verify no personal data before pushing**
   ```bash
   git status
   # Should NOT show: .env.local, *.jks, credentials.json, etc.
   ```

---

## 🔍 Audit Your Repository

Before publishing, run this audit:

```bash
# Check for common sensitive patterns
echo "🔍 Checking for sensitive files..."

patterns=(
    "password"
    "secret"
    "api_key"
    "apiKey"
    "bearer"
    "token"
    "@gmail.com"
    "@yahoo.com"
    "/Users/"
    "/home/"
)

for pattern in "${patterns[@]}"; do
    echo "Searching for: $pattern"
    git grep -i "$pattern" -- "*.dart" "*.gradle" "*.xml" "*.plist" || echo "  ✅ Not found"
done
```

---

## ✅ Privacy Verification Checklist

- [ ] No personal emails in code
- [ ] No personal names in code
- [ ] No local paths (e.g., `/Users/usuario/...`)
- [ ] No API keys or secrets
- [ ] No personal bundle IDs
- [ ] No signing certificates
- [ ] No keystore files
- [ ] No credentials files
- [ ] `.gitignore` properly configured
- [ ] `.env.example` provided (not `.env`)
- [ ] `setup_local.sh` script provided
- [ ] README includes security notice
- [ ] All sensitive data marked in comments

---

## 🚨 If You Accidentally Committed Sensitive Data

1. **STOP** - Do not push to GitHub yet

2. **Remove from staging**
   ```bash
   git reset HEAD <sensitive-file>
   rm -f <sensitive-file>
   git add .
   git commit --amend --no-edit
   ```

3. **If already pushed to public repository**
   ```bash
   # Remove from history (requires force push)
   git filter-branch --tree-filter 'rm -f <sensitive-file>' -- --all
   git push origin main --force-with-lease
   ```

4. **Rotate credentials** - If API keys or passwords were exposed, rotate them immediately

5. **Notify GitHub** - If sensitive data was publicly visible, report to GitHub Security

---

## 📞 Questions?

If you have questions about privacy or security:

1. Review this file
2. Check `.env.example` for configuration guidelines
3. Review `setup_local.sh` for setup steps
4. Refer to Git documentation on `.gitignore`
5. Open an issue for security concerns (private if possible)

---

## 📚 References

- [Git .gitignore Documentation](https://git-scm.com/docs/gitignore)
- [OWASP: Secrets Management](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)
- [GitHub: Keeping your account and data secure](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure)
- [12 Factor App: Config](https://12factor.net/config)

---

**🔒 Privacy is important. Guard your secrets carefully.**
