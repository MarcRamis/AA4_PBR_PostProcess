Shader "Unlit/Custom_Test"
{
	Properties
	{
		_TexRock("Rock", 2D) = "white" {}
		_TexMoss("Moss", 2D) = "white" {}

	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float3 worldNormal : TEXCOORD1;
				float3 wPos : TEXCOORD2;
			};


			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv = v.uv;
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				o.wPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				return o;
			}

			sampler2D _TexRock;
			sampler2D _TexMoss;

			fixed4 frag(v2f i) : SV_Target
			{
				float step = dot(i.worldNormal, float3(0,1,0));
				float smooth = smoothstep(0, 1, step);
				float4 Sampled2D1 = tex2D(_TexRock, i.uv);
				float4 Sampled2D2 = tex2D(_TexMoss, i.uv);
				return lerp(Sampled2D1, Sampled2D2, smooth.x);
			}
			ENDCG
		}
	}
}


