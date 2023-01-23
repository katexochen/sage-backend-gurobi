# Sage contaier with numerical backends Gurobi

This repo provides a [SageMath](https://www.sagemath.org/) container with an [Gurobi](https://www.gurobi.com/)
and [Sage numerical backends Gurobi](https://github.com/sagemath/sage-numerical-backends-gurobi) installation.

## Get a Gurobi license

Register at [Gurobi](https://www.gurobi.com/) and get a WLS license.

## Interactive sage shell

```shell
IMAGE=ghcr.io/katexochen/sage-backend-gurobi/sage:latest
GRB_LIC=gurobi.lic

docker run \
        -it \
        --rm \
        -v $GRB_LIC:/opt/gurobi/gurobi.lic \
        $IMAGE
```

## Run a sage file

```shell
IMAGE=ghcr.io/katexochen/sage-backend-gurobi/sage:latest
SAGE_FILE=foo.sage
GRB_LIC=gurobi.lic

docker run \
	-it \
	--rm \
	-v $GRB_LIC:/opt/gurobi/gurobi.lic \
	-v $SAGE_FILE:/workspace/run.sage \
	$IMAGE run.sage
```

