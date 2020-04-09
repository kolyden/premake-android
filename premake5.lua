--local NDK_PATH = os.getenv("VS_NdkRoot")

workspace "AndroidNative"
	system "android"
	cppdialect "c++14"
	architecture "ARM"
	location "project"
	targetdir "bin/%{cfg.buildcfg}-%{cfg.platform}"

	configurations { "Debug", "Release" }
	platforms { "ARM", "ARM64" }

	toolchainversion "5.0"
	stl "libc++"
	thumbmode "thumb"

	startproject "AndroidNative.Packaging"

project "AndroidNative.NativeActivity"
	kind "SharedLib"
	files "src/**"
	includedirs {
		"$(StlIncludeDirectories)",
		"$(Sysroot)/usr/include",
		"$(Sysroot)/usr/include/$(AndroidHeaderTriple)",
		"$(VS_NdkRoot)/sources/android/support/include",
		"$(VS_NdkRoot)/sources/android/native_app_glue",
    }
    links { "GLESv1_CM", "EGL" }

project "AndroidNative.Packaging"
	kind "Packaging"
	androidapplibname "AndroidNative.NativeActivity"
	links "AndroidNative.NativeActivity"
	files {
		"res/**",
		"AndroidManifest.xml",
		"build.xml",
		"project.properties"
	}