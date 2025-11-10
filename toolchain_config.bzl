TOOLCHAIN_TYPE = str(Label("//:my_toolchain_type"))

def _toolchain_config_impl(ctx):
    return [
        platform_common.ToolchainInfo(
            tool = ctx.file.tool,
        ),
    ]

toolchain_config = rule(
    implementation = _toolchain_config_impl,
    attrs = {
        "tool": attr.label(cfg = "exec", mandatory = True, allow_single_file = True),
    },
)
