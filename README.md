# Assignment 13 - UI Garden Build Checks

This is the Update for Assignment 13 of my Assignment 12. In this assignment, I have introduced Prettier, ESLint, and Jest validations through Husky pre-commit hooks, GitHub Actions CI Pipeline, and Dockerization to run the production build through http://localhost:8018.

## 1. Setup

Copy the Assignment 12 folder, renamed it to 'mahey_tanuj_ui_garden_build_checks', set up a fresh Git repo, and install dependencies:

```bash
cp -r ~/mahey_tanuj_ui_garden ~/mahey_tanuj_ui_garden_build_checks
cd ~/mahey_tanuj_ui_garden_build_checks
rm -rf .git
git init
npm install
npm install --save-dev prettier eslint@^8.57.0 eslint-config-prettier@^9.1.0 eslint-plugin-prettier@^5.1.3 husky
```

## 2. Code Quality Checks

Run these commands anytime to test formatting, linting, and unit tests:

```bash
npm run format:check
npm run format
npm run lint
CI=true npm test
```

## 3. Husky Pre-Commit Hook

The Husky pre-commit hooks were setup using the following command: `npx husky init`. I then configured it in .husky/pre-commit. Every time I commit, `npm run format:check`, `npm run lint` and `CI=true npm test` are run automatically. Commit will not be possible if any of these fails.

To test that Husky blocks bad commits, break formatting or add an unused variable and run:

```bash
git add .
git commit -m "--Cmmnt--"
```

## 4. GitHub Actions & Git Push Commands

Commands used to push to GitHub:

```bash
git add .
git commit -m "Assignment 13: UI Garden with Prettier, ESLint, Husky, GitHub Actions, and Docker"
git branch -M main
git remote add origin https://github.com/tmahey/mahey_tanuj_ui_garden_build_checks.git
git push -u origin main
```

## 5. Run with Docker on localhost:8018

The `Dockerfile` builds the React app inside `/mahey_tanuj_ui_garden_build_checks` and serves the production files with Nginx on port `8018`.

Build the image:

```bash
docker build -t mahey_tanuj_ui_garden_image .
```

Run the container:

```bash
docker run -d -p 8018:8018 --name mahey_tanuj_coding_assignment13 mahey_tanuj_ui_garden_image
```

Check that it is running:

```bash
docker ps
```

Open the app in the browser at `http://localhost:8018` or `http://127.0.0.1:8018`.

Stop and remove the container when done:

```bash
docker stop mahey_tanuj_coding_assignment13
docker rm mahey_tanuj_coding_assignment13
```