plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle plugin must be applied after Android/Kotlin plugins
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.challenge_me_app"

    // Updated to match plugin requirements
    compileSdk = 34
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.example.challenge_me_app"
        minSdk = flutter.minSdkVersion
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildTypes {
        release {
            // Signing config for release (debug for testing, change later)
            signingConfig = signingConfigs.getByName("debug")
            
            // Avoid resource/code shrinking errors
            isMinifyEnabled = false
            isShrinkResources = false

            // ProGuard files (optional if minify disabled)
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}
