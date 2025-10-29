plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
    // 5 - Añadimos el plugin parzelize
    id("kotlin-parcelize")
}

android {
    namespace = "org.iesch.app_MENU_ESTHER"
    compileSdk = 36

    defaultConfig {
        applicationId = "org.iesch.app_MENU_ESTHER"
        minSdk = 24
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = "11"
    }

    buildFeatures {
        viewBinding = true
    }
}

dependencies {

    // Retrofit
    implementation("com.squareup.retrofit2:retrofit:2.9.0")
    implementation("com.squareup.retrofit2:converter-gson:2.9.0")
    // Picasso
    implementation("com.squareup.picasso:picasso:2.8")
    // Corrutinas
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.3.9")
    // DataStore
    implementation("androidx.datastore:datastore-preferences:1.1.7")
   /* //Splash screen
    implementation("androidx.core:core-splashscreen:1.0.0")
    implementation("com.mapbox.maps:android-ndk27:11.16.1")*/

    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.appcompat)
    implementation(libs.material)
    implementation(libs.androidx.activity)
    implementation(libs.androidx.constraintlayout)
    implementation(libs.androidx.recyclerview)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)
}