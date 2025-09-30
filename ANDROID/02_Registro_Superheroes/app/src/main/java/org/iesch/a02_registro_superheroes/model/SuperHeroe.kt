package org.iesch.a02_registro_superheroes.model

import android.os.Parcelable
import kotlinx.parcelize.Parcelize

//6. me creo el objeto superheroe y lo hago parcerable
@Parcelize
data class SuperHeroe (
    val nombre: String,
    val alterEgo: String,
    val bio: String,
    val power: Float
) : Parcelable