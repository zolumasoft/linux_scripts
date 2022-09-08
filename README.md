# Bash Scripts

Linux scripts for random things

## Installing Go on Linux

Usage:

* **amd64**

    ```bash
    ./install_linux_go.sh 1.19.1 amd64
    ```

    OR (**just version 1.16 on amd64**)

    ```bash
    ./install_linux_go.sh
    ```

    **NOTE**: Default architecture is amd64. The default go version is 1.16

* **arm64**

    ```bash
    ./install_linux_go.sh 1.19.1 arm64
    ```

**IMPORTANT**: You have to specify a version of go if you want to include the architecture.
