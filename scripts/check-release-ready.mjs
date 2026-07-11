import { execFileSync } from "node:child_process";

function git(args) {
  return execFileSync("git", args, { encoding: "utf8" }).trim();
}

function fail(message) {
  console.error(`release:check failed: ${message}`);
  process.exit(1);
}

const branch = git(["branch", "--show-current"]);
if (branch !== "main") {
  fail(`current branch is "${branch}". Switch to main before checking production readiness.`);
}

const dirty = git(["status", "--porcelain"]);
if (dirty) {
  fail("working tree has uncommitted changes. Commit or stash them before checking production readiness.");
}

git(["fetch", "origin", "main"]);

const localMain = git(["rev-parse", "main"]);
const remoteMain = git(["rev-parse", "origin/main"]);
if (localMain !== remoteMain) {
  fail("local main and origin/main differ. Push or pull main, then run this check again.");
}

console.log("release:check passed: build is valid and main matches origin/main.");
