# Demo Project Setup

This is a demo project to showcase how to use [Shaper](github.com/taleshape-com/shaper) with a file-based workflow to develop and deploy dashboards.

The project uses Python's package manager `pip` to install the `shaper` binary.

A Shaper instance is running locally to serve the dashboards.


## System requirements
- Python 3.9+ with `pip`
- `make`

## Install
```bash
make install
```
This creates `.venv` and installs `shaper-bin` pinned to the version in the `Makefile`.

## Run
Open two terminals:
1) Terminal A: start the local server
```bash
make serve
```
2) Terminal B: deploy
```bash
make deploy
```

## Develop

Terminal B: Run the dev file watcher:
```bash
make dev
```
Then create and edit dashboards in the `dashboards/` folder.


## License

MIT License
