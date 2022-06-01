Shader "Hidden/Custom/Bloom"
{
	HLSLINCLUDE

		// StdLib.hlsl holds pre-configured vertex shaders (VertDefault), varying structs (VaryingsDefault), and most of the data you need to write common effects.
	#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"


	TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);

	float _intensity;
	float _quantity;

	float _StandardDeviation = 0.02;

	float4 Frag(VaryingsDefault i) : SV_Target
	{
		

	}
		ENDHLSL

		SubShader
	{
		Cull Off ZWrite Off ZTest Always
			Pass
		{
			HLSLPROGRAM
				#pragma vertex VertDefault
				#pragma fragment Frag
			ENDHLSL
		}
	}
}

