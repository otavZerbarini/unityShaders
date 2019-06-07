Shader "Custom/Flip Normals" 
{
	/* _MainTex: es la textura que pide unity cuando se agrega el shader al material o el material al objeto, 
	en el caso de usar un video en vez de una textura seria lo mismo, el shader no se dara cuenta de la diferencia,
	todo el trabajo de mantener actualizada la textura con cada frame del video se hace antes de ejecutar el shader */
    Properties 
	{
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }
    SubShader 
	{
		/*RenderType: indica a la placa de video que los materiales que usen este shader seran opacos o transparentes
		 Tags { "RenderType" = "Transparent-1" }*/
        Tags { "RenderType" = "Opaque" }

		/* cull mode: es utilizado para indicar cuando un triangulo es renderizado y cuando no.
		por defecto solo se dibujan aquellos que miran hacia la camara (Cull Back).
		Cull Off, Back o Front */
        Cull Front

		/* unity usa un lenguaje de shaders creado por nvidia hace un tiempo llamado cg (C para graficos) */
        CGPROGRAM

		/* un shader es un programa que ejecuta la placa de video que permite sobrecargar etapas en el proceso de renderizado de objetos, 
		 puede trabajar a nivel de vertices (vertext shaders) y/o a nivel de pixeles (pixel, surface o fragment shader),
		 para mas informacion buscar sobre shaders y graphics pipeline */

        #pragma surface surf Lambert vertex:vert
        sampler2D _MainTex;

        struct Input {
            float2 uv_MainTex;
            float4 color : COLOR;
        };

		/* programa que se ejecuta una vez por cada vertice */
        void vert(inout appdata_full v) {
            v.normal.xyz = v.normal * -1;
        }

		/* programa que se ejecuta una vez por cada pixel */
        void surf (Input IN, inout SurfaceOutput o) {
             fixed3 result = tex2D(_MainTex, IN.uv_MainTex);
             o.Albedo = result.rgb;
             o.Alpha = 1;
        }

        ENDCG
    }
	  /*si por alguna razon el no se puede usar el shader custom, usar el que viene con unity llamado Diffuse,
	  podriamos especificar cualquier otro alternativo*/
      Fallback "Diffuse"
}