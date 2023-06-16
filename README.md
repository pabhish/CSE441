## Simple Python Based app to display Universal Date and Time in Browser.

### Steps:
1. Clone this repository with `git clone https://github.com/projectaccuknox/uni-date.git`
2. Change working directory to cloned repository `cd uni-date`
3. Execute `sh start.sh <hub-user>/<repo-name>[:<tag>]`

Where 
- `<hub-user>` is your `Docker ID`
- `/` is `delimiter`
- `<repo-name>` is your desired `name for repository`
- `[:<tag>]` is `optional tag`, if you don't use one it will be by default assigned `latest`

### Example
##### Scenario - If my Docker ID is `projectaccuknox` & I want my repository to be named as `uni-date` with tag `v1`, then type in terminal:
```zsh
sh start.sh projectaccuknox/uni-date:v1
```

- Then access this by visiting `http://localhost:8090`
