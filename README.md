# Sage container with Gurobi backend

This repo provides a [SageMath](https://www.sagemath.org/) container with a [Gurobi](https://www.gurobi.com/)
and [Sage numerical backends Gurobi](https://github.com/sagemath/sage-numerical-backends-gurobi) installation.

## Get a Gurobi license

Register at [Gurobi](https://www.gurobi.com/) and get a [WLS](https://www.gurobi.com/features/academic-wls-license/) license.

## Interactive sage shell

```shell
IMAGE=ghcr.io/katexochen/sage-backend-gurobi/sage:latest
GRB_LIC=$(realpath gurobi.lic) # Your gurobi license file.

docker run \
        -it \
        --rm \
        -v $GRB_LIC:/opt/gurobi/gurobi.lic \
        $IMAGE
```

## Run a sage file

```shell
IMAGE=ghcr.io/katexochen/sage-backend-gurobi/sage:latest
SAGE_FILE=$(realpath foo.sage) # Replace foo.sage with the sage file you want to execute.
GRB_LIC=$(realpath gurobi.lic) # Your gurobi license file.

docker run \
	--rm \
	-v $GRB_LIC:/opt/gurobi/gurobi.lic \
	-v $SAGE_FILE:/workspace/run.sage \
	$IMAGE run.sage
```

## Troubleshooting Gurobi license problems

If there are problems with Gurobi, e.g., Python exceptions during sage execution,
you might want to check if Gurobi is happy with the license you've provided. You
can start the container with the interactive Gurobi shell as entrypoint. Gurobi
will print license errors at startup.

```shell
IMAGE=ghcr.io/katexochen/sage-backend-gurobi/sage:latest
GRB_LIC=$(realpath gurobi.lic) # Your gurobi license file.

docker run \
        -it \
	--rm \
	-v $GRB_LIC:/opt/gurobi/gurobi.lic \
	--entrypoint gurobi.sh \
	$IMAGE
```

Example error output (no license file provided):

```
Python 3.7.14 (default, Sep 15 2022, 10:56:34)
[GCC 4.8.5 20150623 (Red Hat 4.8.5-44)] on linux
Type "help", "copyright", "credits" or "license" for more information.
Set parameter LogFile to value "gurobi.log"

No HostID specified in license file
```

Example output if everything is okay:

```
Python 3.7.14 (default, Sep 15 2022, 10:56:34)
[GCC 4.8.5 20150623 (Red Hat 4.8.5-44)] on linux
Type "help", "copyright", "credits" or "license" for more information.
Set parameter WLSAccessID
Set parameter WLSSecret
Set parameter LicenseID to value 474747
Set parameter LogFile to value "gurobi.log"
Academic license - for non-commercial use only - registered to foo@bar.de

Gurobi Interactive Shell (linux64), Version 10.0.0
Copyright (c) 2022, Gurobi Optimization, LLC
Type "help()" for help
```

Notice that Gurobi WLS licenses are scoped to a host ID, and every invocation
of the container uses a fresh ID. If you could execute thing before, and it
suddenly fails, try to wait 5min and retry.
