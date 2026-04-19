# 📤 GitHub Publication Guide

**Step-by-step instructions to publish Material 3 Expressive Explosion as a public GitHub repository.**

---

## ⚠️ Pre-Publication Security Check

Before publishing, run the security audit:

```bash
# 1. Verify no sensitive files are staged
git status

# 2. Check for sensitive patterns
echo "🔍 Security Audit:"
git grep -i "password\|secret\|api.key\|@gmail\|/Users/" -- "*.dart" "*.gradle" "*.xml" "*.plist" || echo "✅ No obvious sensitive data found"

# 3. Verify .gitignore is protecting sensitive files
git check-ignore -v .env.local .env *.jks *.keystore || echo "✅ .gitignore properly configured"

# 4. Verify generic bundle IDs in repository
grep -n "com.example.m3e_demo" android/app/build.gradle.kts || echo "⚠️  Check Android bundle ID"
grep -n "com.example" ios/Runner/Info.plist || echo "⚠️  Check iOS bundle ID"
```

**Expected Results:**
- ✅ `.env.local` is NOT tracked by Git
- ✅ No passwords, API keys, or secrets found
- ✅ No personal paths in version control
- ✅ Generic bundle IDs in repository (your personal ones only locally)

---

## 🚀 Publication Steps

### Step 1: Initialize Git Repository (if not already done)

```bash
cd /Users/usuario/dev/m3e_demo

# Initialize Git
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Add all files (except those in .gitignore)
git add .

# Create initial commit
git commit -m "Initial commit: Material 3 Expressive Explosion - MVVM Architecture Showcase"
```

### Step 2: Create GitHub Repository

1. Go to [GitHub.com](https://github.com) and sign in
2. Click **+** → **New repository**
3. Fill in repository details:
   - **Repository name:** `m3e_explosion` (or `Material-3-Expressive-Explosion`)
   - **Description:** "Material 3 Expressive Explosion - A comprehensive Material Design 3 showcase app with MVVM architecture, animations, and interactive components."
   - **Visibility:** **Public** ✅
   - **Initialize this repository with:** (leave unchecked - we'll push existing)
   - **License:** MIT (add from list)
4. Click **Create repository**

### Step 3: Link Local Repository to GitHub

```bash
# Add remote origin (replace USERNAME with your GitHub username)
git remote add origin https://github.com/USERNAME/m3e_explosion.git

# Verify connection
git remote -v
# Output should show:
# origin  https://github.com/USERNAME/m3e_explosion.git (fetch)
# origin  https://github.com/USERNAME/m3e_explosion.git (push)
```

### Step 4: Push to GitHub

```bash
# Rename branch to main (GitHub default)
git branch -M main

# Push to GitHub
git push -u origin main

# You'll be prompted for credentials:
# - Username: your GitHub username
# - Password: GitHub Personal Access Token (PAT) or password
```

**Create a Personal Access Token (if needed):**
1. Go to GitHub → Settings → Developer settings → Personal access tokens
2. Click "Generate new token"
3. Select scopes: `repo`, `workflow`
4. Copy token and use as password when prompted

### Step 5: Add License File

```bash
# Create MIT License file
cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2024 Material 3 Expressive Explosion Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# Commit and push
git add LICENSE
git commit -m "Add MIT License"
git push origin main
```

### Step 6: Add GitHub-Specific Files

#### Create `.github/workflows/` for CI/CD (optional)

```bash
mkdir -p .github/workflows

cat > .github/workflows/flutter-analyze.yml << 'EOF'
name: Flutter Analyze

on: [push, pull_request]

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze
EOF

git add .github/
git commit -m "Add CI/CD workflow for flutter analyze"
git push origin main
```

#### Create CONTRIBUTING.md

```bash
cat > CONTRIBUTING.md << 'EOF'
# Contributing to Material 3 Expressive Explosion

We welcome contributions! Please read these guidelines:

## How to Contribute

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/MyFeature`
3. Make your changes
4. Commit: `git commit -m "Add MyFeature"`
5. Push: `git push origin feature/MyFeature`
6. Open a Pull Request

## Code Standards

- Run `flutter analyze` before submitting
- Format code: `dart format .`
- Add Dartdoc comments to public APIs
- Write clear commit messages

## Security

Please report security vulnerabilities privately. DO NOT create public issues for security problems.

---

Thank you for contributing! 🎉
EOF

git add CONTRIBUTING.md
git commit -m "Add contribution guidelines"
git push origin main
```

### Step 7: Update README.md

Replace the existing `README.md` with the public version:

```bash
# Backup current README
cp README.md README_BACKUP.md

# Use the public README
cp README_PUBLIC.md README.md

# Commit
git add README.md
git commit -m "Update README for public release"
git push origin main
```

### Step 8: Tag Release (optional)

```bash
# Create a version tag
git tag -a v1.0.0 -m "Initial public release"
git push origin v1.0.0
```

---

## ✅ Post-Publication Verification

After pushing to GitHub, verify:

1. **Visit your repository:** `https://github.com/USERNAME/m3e_explosion`

2. **Verify files are present:**
   - ✅ README.md
   - ✅ pubspec.yaml
   - ✅ lib/ folder with all source code
   - ✅ ARCHITECTURE.md
   - ✅ SECURITY_PRIVACY.md
   - ✅ .env.example
   - ✅ setup_local.sh

3. **Verify sensitive files are NOT present:**
   - ❌ .env.local (should not be there)
   - ❌ *.jks files (should not be there)
   - ❌ Certificates (should not be there)

4. **Check GitHub shows README:**
   - Repository page should display README.md nicely

5. **Check license:**
   - GitHub should show license in sidebar

---

## 🔄 Future Updates

After publishing, to update your repository:

```bash
# Make changes locally
# Example: update code, add features, fix bugs

# Stage changes
git add .

# Commit with descriptive message
git commit -m "Description of changes"

# Push to GitHub
git push origin main
```

---

## 📋 Checklist Before Going Public

- [ ] Local `.env.local` created and contains YOUR bundle ID
- [ ] `.gitignore` updated with sensitive file patterns
- [ ] `setup_local.sh` tested and working
- [ ] `SECURITY_PRIVACY.md` reviewed
- [ ] `README_PUBLIC.md` renamed to `README.md`
- [ ] ARCHITECTURE.md present and accurate
- [ ] No personal data (names, emails, paths) in committed files
- [ ] Generic bundle IDs in Android/iOS config files
- [ ] YouTube video ID verified (currently: 6YD25EoV5Oo)
- [ ] `flutter analyze` returns 0 errors
- [ ] LICENSE file added
- [ ] GitHub repository created and public
- [ ] Initial commit pushed successfully
- [ ] Repository README displays correctly on GitHub
- [ ] Verified sensitive files are NOT in repository

---

## 🆘 Troubleshooting

### "Permission denied (publickey)"

```bash
# Generate SSH key (if not already done)
ssh-keygen -t ed25519 -C "your.email@example.com"

# Add to GitHub: Settings → SSH and GPG keys → New SSH key

# Change remote to SSH
git remote set-url origin git@github.com:USERNAME/m3e_explosion.git

# Try push again
git push -u origin main
```

### "src refspec main does not match any"

```bash
# Create initial commit first
git add .
git commit -m "Initial commit"

# Then rename and push
git branch -M main
git push -u origin main
```

### "fatal: remote origin already exists"

```bash
# Remove existing remote
git remote remove origin

# Add new remote
git remote add origin https://github.com/USERNAME/m3e_explosion.git
```

---

## 📱 Next Steps After Publishing

1. **Share the repository** with others
2. **Add topics** on GitHub (flutter, material-design-3, mvvm, dart)
3. **Create GitHub Pages** documentation (optional)
4. **Setup Issues** template for bug reports
5. **Setup Pull Request** template for contributions
6. **Monitor activity** and respond to issues/PRs

---

## 🎉 Success!

Your project is now public on GitHub! 

**Repository URL:** `https://github.com/USERNAME/m3e_explosion`

**Share it with:**
- ✅ Flutter community
- ✅ Your portfolio
- ✅ GitHub trending
- ✅ Reddit r/FlutterDev
- ✅ Friends & colleagues

---

**Happy publishing! 🚀**

Remember: Your personal data is safe locally in `.env.local` and will NOT be pushed to GitHub. ✅
