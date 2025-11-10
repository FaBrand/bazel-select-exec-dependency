load(":toolchain_config.bzl", "TOOLCHAIN_TYPE")

def _toolchain_user_impl(ctx):
    toolchain = ctx.toolchains[TOOLCHAIN_TYPE]
    tool_file = toolchain.tool

    output = ctx.actions.declare_file("output.txt")

    args = ctx.actions.args()
    args.add(output)

    ctx.actions.run(
        outputs = [output],
        inputs = [],
        executable = tool_file,
        arguments = [args],
    )

    print("Used tool", tool_file)

    return DefaultInfo(files = depset([output]))

toolchain_user = rule(
    implementation = _toolchain_user_impl,
    attrs = {},
    toolchains = [TOOLCHAIN_TYPE],
)
