# TIL-github-action

- Today I Learned index generator with github-action
- You can use [actions/checkout](https://github.com/actions/checkout) and [peter-evans/create-pull-request](https://github.com/peter-evans/create-pull-request) together to automate README.md updates.

# Variables

- You can add content to the header by setting a variable called TIL_HEADER in the repository.

# Example

1. Use [actions/checkout](https://github.com/actions/checkout) to perform actions in the workspace.
2. Run TIL-github-action to update README.md
3. Commit the changes.
4. Create a pull request using [peter-evans/create-pull-request](https://github.com/peter-evans/create-pull-request)

```YAML
name: "update readme"

on:
  push:
    branches:
      - main-branch-what-you-want

jobs:
  update-readme:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with: 
          fetch-depth: 0
      - name: Update README
        id: TIL
        uses: yongjulejule/TIL-github-action@v1
        env:
          # The contents of the TIL_HEADER defined in variable in the repository.
          TIL_HEADER: ${{ vars.TIL_HEADER }}
      - name: Commit changes
        run: |
          # Commit the converted file to Git.
          git config --local user.email "action@github.com"
          git config --local user.name "GitHub Action"
          git add README.md
          git commit -m "Update README.md"
      - name: Create Pull Request
        id: cpr
        uses: peter-evans/create-pull-request@v4
        with:
          # Should set the github personal access token with sufficient permissions.
          token: ${{ secrets.PAT }}
          commit-message: Update report
          committer: GitHub <noreply@github.com>
          author: GitHub Action <action@github.com>
          signoff: false
          branch: readme-bot
          delete-branch: true
          title: '[bot] Update README.md'
          body: |
            Update README.md. Please review the changes.
          assignees: ${{ github.actor }}
          reviewers: ${{ github.actor }}
          draft: false
```

# known issues

- If there are spaces in the filename, it may not work correctly.
