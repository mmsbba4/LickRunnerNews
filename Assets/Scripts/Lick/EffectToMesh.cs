using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace Lick
{
    public class EffectToMesh : MonoBehaviour
    {
        public MeshFilter my_mesh;
        private void Start()
        {
            if (my_mesh == null)
            {
                my_mesh = GetComponent<MeshFilter>();
            }
        }
        private void OnTriggerEnter(Collider other)
        {
            if (other.GetComponent<Tongue>() != null)
            {
                other.GetComponent<Tongue>().obj = my_mesh;
            }
        }
    }
}

