﻿Shader "Custom/Plane"
{
    Properties
    {
		_Color("Tint Color",Color) = (1,1,1,1)
		_BackColor("Back Color",Color) = (1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
		_BackTex ("Texture",2D) = "white" {}
    }
    SubShader
    {
        // No culling or depth
        Pass
        {
			Cull Back
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
			fixed4 _Color;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
				col = col * _Color;
                return col;
            }
            ENDCG
        }

		Pass
        {
			Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _BackTex;
			fixed4 _BackColor;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_BackTex, i.uv);
				col = col * _BackColor;
                return col;
            }
            ENDCG
        }
    }
}
