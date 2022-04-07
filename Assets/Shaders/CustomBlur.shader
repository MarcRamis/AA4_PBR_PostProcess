Shader "Hidden/Custom/Blur"
{
	HLSLINCLUDE
		// StdLib.hlsl holds pre-configured vertex shaders (VertDefault), varying structs (VaryingsDefault), and most of the data you need to write common effects.
#include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

		TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);

	float _intensity;
	float4 Frag(VaryingsDefault i) : SV_Target
	{
		//float4 color = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord);
		//float4 color2 = float4(1,1,1,1) - color;
		//color.rgb = lerp(color.rgb, color2.rgb, _intensity.xxx);
		// Return the result
		//return color;

		//calculate aspect ratio
		float invAspect = _ScreenParams.y / _ScreenParams.x;
		//init color variable
		float4 col = 0;
		//iterate over blur samples
		for (float index = 0; index < 10; index++) {
			//get uv coordinate of sample
			float2 uv = i.texcoord + float2((index / 9 - 0.5) * 0.1 * invAspect, 0);
			//add color at position to color
			col += SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, uv);
		}
		//divide the sum of values by the amount of samples
		col = col / 10;
		return col;


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
