load(":toolchain_config.bzl", "TOOLCHAIN_TYPE", "toolchain_config")
load(":toolchain_user.bzl", "toolchain_user")

exports_files([
    "linux_tool.bash",
    "windows_tool.bat",
])

###################################
# exec
constraint_setting(
    name = "exec_constraint",
)

constraint_value(
    name = "some_exec_constraint",
    constraint_setting = ":exec_constraint",
)

platform(
    name = "exec_platform",
    constraint_values = [
        "some_exec_constraint",
        "@platforms//cpu:x86_64",
    ],
)

###################################
# Target
constraint_value(
    name = "some_cpu",
    constraint_setting = "@platforms//cpu",
)

constraint_value(
    name = "some_os",
    constraint_setting = "@platforms//os",
)

platform(
    name = "my_platform",
    constraint_values = [
        ":some_cpu",
        ":some_os",
    ],
)

toolchain_type(
    name = "my_toolchain_type",
)

# Working:

toolchain_config(
    name = "working_toolchain_config",
    tool = ":tool",
)

alias(
    name = "tool",
    actual = select({
        ":some_exec_constraint": "//:some_special_tool.bash",
        "//conditions:default": "//:linux_tool.bash",
    }),
)

# Not-Working:
#
toolchain_config(
    name = "broken_toolchain_config",
    tool = select({
        ":some_exec_constraint": "//:some_special_tool.bash",
        "//conditions:default": "//:linux_tool.bash",
    }),
)

toolchain(
    name = "working_toolchain",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":working_toolchain_config",
    toolchain_type = TOOLCHAIN_TYPE,
)

toolchain(
    name = "broken_toolchain",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":broken_toolchain_config",
    toolchain_type = TOOLCHAIN_TYPE,
)

toolchain_user(
    name = "toolchain_consumer",
)
