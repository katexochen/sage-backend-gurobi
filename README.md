# Sage container with Gurobi backend

This repo provides a [SageMath](https://www.sagemath.org/) container with a [Gurobi](https://www.gurobi.com/)
and [Sage numerical backends Gurobi](https://github.com/sagemath/sage-numerical-backends-gurobi) installation.

## Get a Gurobi license

Register at [Gurobi](https://www.gurobi.com/) and get a [WLS](https://www.gurobi.com/features/academic-wls-license/) license.

## Interactive sage shell

```shell
IMAGE=ghcr.io/katexochen/sage-backend-gurobi/sage:latest
GRB_LIC=$(realpath gurobi.lic)

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
